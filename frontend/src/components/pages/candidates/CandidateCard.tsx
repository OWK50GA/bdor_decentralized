import Image from "next/image";
import Link from "next/link";
import GenericImage from '../../../../public/actual-bdor-image.png'
import { Player } from "@/lib/data";

const CandidateCard = ({rank, noOfVotes, name, club}: Partial<Player>) => {
    return ( 
        <div className="">
            <div className="px-5 py-5 shadow-gold w-fit flex flex-col justify-center hover:shadow-gold-hover gap-5">
                <div className="flex justify-between items-center w-full text-gold-500 font-bold">
                    <p>#{rank}</p>
                    <p>{noOfVotes} votes</p>
                </div>
                <div>
                    <Image src={GenericImage} alt="Erling Haaland" />
                </div>
                <div className="flex flex-col gap-2 text-lg">
                    <p className="font-bold">{name}</p>
                    <p className="font-bold">{club}</p>
                    <Link href={''} className="text-gold-500 hover:underline">View Profile &rsaquo;</Link>
                </div>
            </div>
        </div>
    );
}
 
export default CandidateCard;